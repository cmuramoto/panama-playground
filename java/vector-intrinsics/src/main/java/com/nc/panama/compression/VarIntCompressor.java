package com.nc.panama.compression;

import java.util.Arrays;

import jdk.incubator.vector.ByteVector;
import jdk.incubator.vector.ByteVector.ByteSpecies;
import jdk.incubator.vector.IntVector;
import jdk.incubator.vector.IntVector.IntSpecies;
import jdk.incubator.vector.ShortVector;
import jdk.incubator.vector.ShortVector.ShortSpecies;
import jdk.incubator.vector.Vector.Mask;
import jdk.incubator.vector.Vector.Shape;
import jdk.incubator.vector.Vector.Shuffle;

public class VarIntCompressor {

	static class Guards {
		static final IntVector byte1_test = _mm256i.broadcast(0x80);
		static final IntVector byte2_test = _mm256i.broadcast(0x4000);
		static final IntVector byte3_test = _mm256i.broadcast(0x200000);
		static final IntVector byte4_test = _mm256i.broadcast(0x10000000);
		static final Mask<Integer> allTrue = _mm256i.maskAllTrue();
		static final Mask<Short> evenIndexes = _mm256i_short.maskFromValues(true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false);
	}

	static final IntSpecies _mm256i = IntVector.species(Shape.S_256_BIT);
	static final ByteSpecies _mm256i_byte = ByteVector.species(Shape.S_256_BIT);
	static final ShortSpecies _mm256i_short = ShortVector.species(Shape.S_256_BIT);
	static final ShortSpecies _mm128i_short = ShortVector.species(Shape.S_128_BIT);
	static final ByteSpecies _mm64i_byte = ByteVector.species(Shape.S_64_BIT);
	static final ByteSpecies _mm128i_byte = ByteVector.species(Shape.S_128_BIT);

	static final Guards guards = new Guards();

	public static void compress(int[] src, byte[] dst) {
		compress(src, dst, 0, 0);
	}

	public static int compress(int[] src, byte[] dst, int soff, int doff) {
		int slim = (src.length - src.length % 8) - 8;
		int tail = (src.length - soff) % 8;

		while (soff <= slim) {
			var chunk = _mm256i.fromArray(src, soff, Guards.allTrue);

			if (chunk.lessThan(Guards.byte1_test).allTrue()) {
				var vector = chunk.reinterpret(_mm256i_byte);

				var rearrange = vector.rearrange(compress1());
				rearrange = rearrange.reshape(_mm64i_byte);

				rearrange.intoByteArray(dst, doff);

				doff += 8;

			} else if (chunk.lessThan(Guards.byte2_test).allTrue()) {
				var tmp = chunk.shiftR(7).and(0xFF);
				var high = (ByteVector) tmp.reinterpret(_mm256i_byte).rearrange(compress2()).shiftER(1).reshape(_mm128i_byte);

				tmp = chunk.and(0xFF).or(0x80).and(0xFF);
				var low = (ByteVector) tmp.reinterpret(_mm256i_byte).rearrange(compress2()).reshape(_mm128i_byte);

				var store = low.or(high);

				store.intoArray(dst, doff);

				doff += 16;
			} else if (chunk.lessThan(Guards.byte3_test).allTrue()) {

				doff = compressScalar(src, dst, soff, doff, soff + 8); // should a
			} else if (chunk.lessThan(Guards.byte4_test).allTrue()) {
				var tmp = chunk.shiftR(21).and(0xFF);
				var q3 = (ByteVector) tmp.reinterpret(_mm256i_byte).shiftER(3);
				tmp = chunk.shiftR(14).or(0x80).and(0xFF);
				var q2 = (ByteVector) tmp.reinterpret(_mm256i_byte).shiftER(2);
				tmp = chunk.shiftR(7).or(0x80).and(0xFF);
				var q1 = (ByteVector) tmp.reinterpret(_mm256i_byte).shiftER(1);
				tmp = chunk.and(0x7F).or(0x80).and(0xFF);
				var q0 = (ByteVector) tmp.reinterpret(_mm256i_byte);

				var store = q0.or(q1.or(q2.or(q3)));

				store.intoArray(dst, doff);

				doff += 32;
			} else {
				doff = compressScalar(src, dst, soff, doff, soff + 8);
			}

			soff += 8;
		}

		if (tail != 0) {
			compressScalar(src, dst, soff, doff, soff + tail);
		}

		return doff;
	}

	static Shuffle<Byte> compress1() {
		return _mm256i_byte.shuffle(i -> {
			var rv = i * 4;
			return rv;
		});
	}

	static Shuffle<Byte> compress2() {
		return _mm256i_byte.shuffle(i -> {
			var rv = (i & 1) != 0 ? i * 2 - 1 : i * 2;
			return rv;
		});
	}

	static Shuffle<Byte> compress4() {
		return _mm256i_byte.shuffle(i -> {
			var rv = (i & 1) != 0 ? i * 2 - 1 : i * 2;
			return rv;
		});
	}

	public static int compressScalar(int[] src, byte[] dst) {
		return compressScalar(src, dst, 0, 0);
	}

	public static int compressScalar(int[] src, byte[] dst, int soff, int doff) {
		return compressScalar(src, dst, soff, doff, src.length);
	}

	public static int compressScalar(int[] src, byte[] dst, int soff, int doff, int slim) {

		for (int i = soff; i < slim; i++) {
			int v = src[i];

			if (v >>> 7 == 0) {
				dst[doff++] = (byte) v;
			} else if (v >>> 14 == 0) {
				dst[doff++] = (byte) (v & 0x7F | 0x80);
				dst[doff++] = (byte) (v >>> 7);
			} else if (v >>> 21 == 0) {
				dst[doff++] = (byte) (v & 0x7F | 0x80);
				dst[doff++] = (byte) (v >>> 7 | 0x80);
				dst[doff++] = (byte) (v >>> 14);
			} else if (v >>> 28 == 0) {
				dst[doff++] = (byte) (v & 0x7F | 0x80);
				dst[doff++] = (byte) (v >>> 7 | 0x80);
				dst[doff++] = (byte) (v >>> 14 | 0x80);
				dst[doff++] = (byte) (v >>> 21);
			} else {
				dst[doff++] = (byte) (v & 0x7F | 0x80);
				dst[doff++] = (byte) (v >>> 7 | 0x80);
				dst[doff++] = (byte) (v >>> 14 | 0x80);
				dst[doff++] = (byte) (v >>> 21 | 0x80);
				dst[doff++] = (byte) (v >>> 28);
			}
		}
		return doff;
	}

	public static int compressScalar1(int[] src, byte[] dst, int soff, int doff, int slim) {

		for (int i = soff; i < slim; i++) {
			int v = src[i];
			dst[doff++] = (byte) v;
		}
		return doff;
	}

	public static int compressScalar2(int[] src, byte[] dst, int soff, int doff, int slim) {

		for (int i = soff; i < slim; i++) {
			int v = src[i];
			dst[doff++] = (byte) (v & 0x7F | 0x80);
			dst[doff++] = (byte) (v >>> 7);
		}
		return doff;
	}

	// Branchless Version
	public static int compressScalar3(int[] src, byte[] dst, int soff, int doff, int slim) {
		for (int i = soff; i < slim; i++) {
			int v = src[i];

			dst[doff++] = (byte) (v & 0x7F | 0x80);
			dst[doff++] = (byte) (v >>> 7 | 0x80);
			dst[doff++] = (byte) (v >>> 14);
		}
		return doff;
	}

	public static int compressScalar4(int[] src, byte[] dst, int soff, int doff, int slim) {
		for (int i = soff; i < slim; i++) {
			int v = src[i];

			dst[doff++] = (byte) (v & 0x7F | 0x80);
			dst[doff++] = (byte) (v >>> 7 | 0x80);
			dst[doff++] = (byte) (v >>> 14 | 0x80);
			dst[doff++] = (byte) (v >>> 21);
		}
		return doff;
	}

	public static int compressScalar5(int[] src, byte[] dst, int soff, int doff, int slim) {
		for (int i = soff; i < slim; i++) {
			int v = src[i];

			dst[doff++] = (byte) (v & 0x7F | 0x80);
			dst[doff++] = (byte) (v >>> 7 | 0x80);
			dst[doff++] = (byte) (v >>> 14 | 0x80);
			dst[doff++] = (byte) (v >>> 21 | 0x80);
			dst[doff++] = (byte) (v >>> 28);
		}
		return doff;
	}

	public static int testVectorAndcompressScalar(int[] src, byte[] dst, int soff, int doff) {
		int slim = (src.length - src.length % 8) - 8;
		int tail = (src.length - soff) % 8;

		while (soff <= slim) {
			var chunk = _mm256i.fromArray(src, soff, Guards.allTrue);

			if (chunk.lessThan(Guards.byte1_test).allTrue()) {
				doff = compressScalar1(src, dst, soff, doff, soff + 8);
			} else if (chunk.lessThan(Guards.byte2_test).allTrue()) {
				doff = compressScalar2(src, dst, soff, doff, soff + 8);
			} else if (chunk.lessThan(Guards.byte3_test).allTrue()) {
				doff = compressScalar3(src, dst, soff, doff, soff + 8);
			} else if (chunk.lessThan(Guards.byte4_test).allTrue()) {
				doff = compressScalar4(src, dst, soff, doff, soff + 8);
			} else {
				doff = compressScalar(src, dst, soff, doff, soff + 8);
			}

			soff += 8;
		}

		if (tail != 0) {
			compressScalar(src, dst, soff, doff, soff + tail);
		}

		return doff;
	}

	public static String toUnsigned(ByteVector bv) {
		int len = bv.length();
		var arr = new int[len];
		for (int i = 0; i < len - 1; i++) {
			arr[i] = bv.get(i) & 0xFF;
		}
		return Arrays.toString(arr);
	}

}
