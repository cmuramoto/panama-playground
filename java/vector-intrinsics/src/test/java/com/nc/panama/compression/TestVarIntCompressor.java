package com.nc.panama.compression;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;

@RunWith(Parameterized.class)
public class TestVarIntCompressor {

	enum Category {
		ONE_BYTE(0, 0x80), //
		TWO_BYTES(0x80, 0x4000), //
		THREE_BYTES(0x4000, 0x200000), //
		FOUR_BYTES(0x200000, 0x10000000), //
		FIVE_BYTES(0x10000000, Integer.MAX_VALUE), RANDOM(Integer.MIN_VALUE, Integer.MAX_VALUE);

		int min;
		int max;

		private Category(int min, int max) {
			this.min = min;
			this.max = max;
		}

		IntStream create(boolean seq, int count) {
			if (seq) {
				return IntStream.iterate(min, prev -> {
					int rv = prev + 1;
					return rv >= max ? min : rv;
				}).limit(count);
			} else {
				return IntStream.generate(() -> ThreadLocalRandom.current().nextInt(min, max)).limit(count);
			}
		}

		long span() {
			return (long) max - (long) min;
		}
	}

	enum Mode {
		Vector, //
		Scalar, //
		TestVector
	}

	@Parameters(name = "{index}: mode={0}, category={1}, sequential={2}, loops={3}")
	public static Iterable<Object[]> params() {
		var values = Mode.values();
		var categories = new Category[]{ Category.FOUR_BYTES };
		var generateMode = new boolean[]{ true };
		var lengths = Arrays.asList(100_000, 1_000_000, 10_000_000);

		var rv = new ArrayList<Object[]>();

		for (var mode : values) {
			for (var category : categories) {
				for (var gm : generateMode) {
					for (var len : lengths) {
						rv.add(new Object[]{ mode, category, gm, len });
					}
				}
			}
		}

		return rv;
	}

	@Parameter(0)
	public Mode mode;

	@Parameter(1)
	public Category cat;

	@Parameter(2)
	public boolean sequential;

	@Parameter(3)
	public int loops;

	void doRun() {
		var src = cat.create(sequential, 32).toArray();
		var dst = new byte[src.length * 5];

		long now = System.currentTimeMillis();

		int n = loops;
		switch (mode) {
		case Scalar:
			for (int i = 0; i < n; i++) {
				VarIntCompressor.compressScalar(src, dst, 0, 0);
			}
			System.out.printf("[S]N=%d. Elapsed: %dms\n", n, System.currentTimeMillis() - now);
			break;
		case Vector:
			for (int i = 0; i < n; i++) {
				VarIntCompressor.compress(src, dst);
			}

			System.out.printf("[V]N=%d. Elapsed: %dms\n", n, System.currentTimeMillis() - now);
			break;

		case TestVector:
			for (int i = 0; i < n; i++) {
				VarIntCompressor.testVectorAndcompressScalar(src, dst);
			}

			System.out.printf("[V-S]N=%d. Elapsed: %dms\n", n, System.currentTimeMillis() - now);
			break;
		default:
			break;
		}
	}

	@Test
	public void run() {
		run(3);
	}

	void run(int loops) {
		for (int i = 0; i < loops; i++) {
			doRun();
		}
	}

}