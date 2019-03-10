package com.nc.panama.compression;

import static com.nc.panama.compression.VarIntCompressor._mm256i;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;

import org.junit.Test;

import com.nc.panama.compression.VarIntCompressor.Guards;

public class TestRangeGuards {

	@Test
	public void testByteCountGuards() {
		var bb = ByteBuffer.allocateDirect(256 / 8).order(ByteOrder.nativeOrder());
		var ib = bb.asIntBuffer();

		for (int j = 0; j < 0x80; j++) {
			for (int i = 0; i < ib.capacity(); i++) {
				ib.put(i, j);

				var vector = _mm256i.fromByteBuffer(bb, 0);

				var mask = vector.lessThan(Guards.byte1_test);

				if (!mask.allTrue()) {
					throw new IllegalStateException();
				}
			}
		}

		System.out.println("Byte 1 pass");

		for (int j = 0x80; j < 0x4000; j++) {
			for (int i = 0; i < ib.capacity(); i++) {
				ib.put(i, j);

				var vector = _mm256i.fromByteBuffer(bb, 0);

				var mask = vector.lessThan(Guards.byte2_test);

				if (!mask.allTrue()) {
					throw new IllegalStateException();
				}
			}
		}

		System.out.println("Byte 2 pass");

		for (int j = 0x4000; j < 0x200000; j++) {
			for (int i = 0; i < ib.capacity(); i++) {
				ib.put(i, j);

				var vector = _mm256i.fromByteBuffer(bb, 0);

				var mask = vector.lessThan(Guards.byte3_test);

				if (!mask.allTrue()) {
					throw new IllegalStateException();
				}
			}
		}

		System.out.println("Byte 3 pass");

		for (int j = 0x200000; j < 0x10000000; j++) {
			for (int i = 0; i < ib.capacity(); i++) {
				ib.put(i, j);

				var vector = _mm256i.fromByteBuffer(bb, 0);

				var mask = vector.lessThan(Guards.byte4_test);

				if (!mask.allTrue()) {
					throw new IllegalStateException();
				}
			}
		}

		System.out.println("Byte 4 pass");
	}

}
