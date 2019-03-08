#include "compressor.h"

static int compress_scalar(int *src, byte *dst, int len)
{

  int *sp = &(*src);
  byte *dp = &(*dst);
  int i;
  for (i = 0; i < len; i++)
  {
    int v = *sp++;

    if (ushift(v, 7) == 0)
    {
      *dp++ = (byte)v;
    }
    else if (ushift(v, 14) == 0)
    {
      *dp++ = (byte)(v & 0x7F | 0x80);
      *dp++ = (byte)(ushift(v, 7));
    }
    else if (ushift(v, 21) == 0)
    {
      *dp++ = (byte)(v & 0x7F | 0x80);
      *dp++ = (byte)(ushift(v, 7) | 0x80);
      *dp++ = (byte)(ushift(v, 14));
    }
    else if (ushift(v, 28) == 0)
    {
      *dp++ = (byte)(v & 0x7F | 0x80);
      *dp++ = (byte)(ushift(v, 7) | 0x80);
      *dp++ = (byte)(ushift(v, 14) | 0x80);
      *dp++ = (byte)(ushift(v, 21));
    }
    else
    {
      *dp++ = (byte)(v & 0x7F | 0x80);
      *dp++ = (byte)(ushift(v, 7) | 0x80);
      *dp++ = (byte)(ushift(v, 14) | 0x80);
      *dp++ = (byte)(ushift(v, 21) | 0x80);
      *dp++ = (byte)(ushift(v, 28));
    }
  }

  return (int)(dp - dst);
}

static int decompress_scalar(byte *src, int *dst, int soff, int doff, int slen, int dlen)
{

  byte *sp = &(src[soff]);
  int *dp = &(dst[doff]);

  for (; (sp - src) < slen && (dp - dst) < dlen;)
  {
    int v = *sp++;
    int rv = v & 0x7F;
    if ((v & 0x80) != 0)
    {
      v = *sp++;
      rv |= ((v & 0x7f) << 7);
      if ((v & 0x80) != 0)
      {
        v = *sp++;
        rv |= ((v & 0x7f) << 14);
        if ((v & 0x80) != 0)
        {
          v = *sp++;
          rv |= ((v & 0x7f) << 21);
          if ((v & 0x80) != 0)
          {
            v = *sp++;
            rv |= ((v & 0x7f) << 28);
          }
        }
      }
    }

    *dp++ = rv;
  }

  return (int)(dp - dst);
}

/*
static int decompress_scalar(byte* src, int* dst, int slen) {

  byte* sp = &(*src);
  int* dp = &(*dst);
  int i;
  int s;

  for (i = 0; i < slen; i++) {
    int v = *sp++;
    int rv = v & 0x7F;
    if((v & 0x80)!=0){
      v = *sp++;
      rv |= ((v & 0x7f) << 7);
      if((v & 0x80)!=0){
        v = *sp++;
        rv |= ((v & 0x7f) << 14);
        if((v & 0x80)!=0){
          v = *sp++;
          rv |= ((v & 0x7f) << 21);
          if((v & 0x80)!=0){
            v = *sp++;
            rv |= ((v & 0x7f) << 28);
          } 
        } 
      }
    }
    
    dp[i] = rv;
  }

  return (int)(dp-dst);
}
*/

static int compress(int *src, byte *dst, int soff, int doff, int len)
{
  int tail = len % 8;
  int lim = len - tail;
  int *sp = &src[soff];
  byte *dp = &dst[doff];

  while (lim >= 8)
  {
    vec chunk = _mm256_loadu_si256((__m256i *)sp);

    if (!ALL_GT(byte1_test, chunk))
    {
      //printf("Storing (1b)");
      chunk = _mm256_packus_epi32(chunk, zero);
      chunk = _mm256_packus_epi16(chunk, zero);
      chunk = _mm256_permutevar8x32_epi32(chunk, idx_permute8x32);
      *((long *)dp) = _mm256_extract_epi64(chunk, 0);

      sp += 8;
      dp += 8;
    }
    else if (!ALL_GT(byte2_test, chunk))
    {
      vec high = _mm256_srli_epi32(chunk, 7);
      high = cast_int_to_byte(high);
      high = left_shift_one(high);

      vec low = _mm256_and_si256(chunk, _mm256_set1_epi32(0x7F));
      low = _mm256_or_si256(low, _mm256_set1_epi32(0x80));
      low = cast_int_to_byte(low);

      chunk = _mm256_or_si256(low, high);
      chunk = _mm256_packus_epi32(chunk, zero);
      chunk = _mm256_permute4x64_epi64(chunk, 0x3 << 6 | 0x3 << 4 | 0x2 << 2 | 0);

      __m128i narrow = _mm256_castsi256_si128(chunk);

      _mm_storeu_si128((__m128i *)dp, narrow);

      sp += 8;
      dp += 16;
    }
    else if (!ALL_GT(byte3_test, chunk))
    {
      //to hard to assemble 24 bytes contiguosly :(
      int i;
      for (i = 0; i < 8; i++)
      {
        int v = *sp++;
        *dp++ = (byte)(v & 0x7F | 0x80);
        *dp++ = (byte)(ushift(v, 7) | 0x80);
        *dp++ = (byte)(ushift(v, 14));
      }

      //sp+=8;
      //dp+=24;
    }
    else if (!ALL_GT(byte4_test, chunk))
    {
      vec a = _mm256_and_si256(chunk, _0x7F);
      a = _mm256_or_si256(a, _0x80);
      a = cast_int_to_byte(a);

      vec b = _mm256_srli_epi32(chunk, 7);
      b = _mm256_or_si256(b, _0x80);
      b = cast_int_to_byte(b);
      b = left_shift_one(b);

      vec c = _mm256_srli_epi32(chunk, 14);
      c = cast_int_to_byte(c);
      c = left_shift_two(c);

      vec d = _mm256_srli_epi32(chunk, 21);
      d = cast_int_to_byte(d);
      d = left_shift_three(d);

      //print_epi8(a);
      //print_epi8(b);
      //print_epi8(c);
      //print_epi8(d);

      chunk = _mm256_or_si256(a, _mm256_or_si256(b, _mm256_or_si256(c, d)));
      _mm256_storeu_si256((vec *)dp, chunk);
      //printf("Storing (4b)");
      //print_epi8(chunk);

      dp += 32;
      sp += 8;
    }
    else
    {
      //printf("Storing Scalar ([1-5]b)");
      //print_epi8(chunk);
      compress_scalar(sp, dp, 8);
    }

    lim -= 8;
  }

  if (tail)
  {
    compress_scalar(sp, dp, tail);
  }
}

static inline void decompress3_8(byte *sp, int *dp)
{
  int i;

  for (i = 0; i < 8; i++)
  {
    int rv, v = *sp++;
    rv = v & 0x7F;
    v = *sp++;
    rv |= ((v & 0x7F) << 7);
    v = *sp++;
    rv |= ((v & 0x7F) << 14);
    *dp++ = rv;
  }
}

static int decompress(byte *src, int *dst, int soff, int doff, int slen, int dlen)
{
  byte *sp = &src[soff];
  int *dp = &dst[doff];
  int srem = slen - soff;
  int drem = dlen - doff;

  while (srem >= CHUNK_SIZE_BYTE && drem >= CHUNK_SIZE_INT)
  {
    vec chunk = _mm256_loadu_si256((__m256i *)sp);

    int mask = _mm256_movemask_epi8(chunk);

    if (mask == 0X77777777)
    { //1x(4 byte) seq

      vec a = _mm256_and_si256(chunk, _mm256_set1_epi32(0xFF));
      a = _mm256_and_si256(a, _mm256_set1_epi8(0x7F));

      vec b = _mm256_and_si256(_mm256_srli_epi32(chunk, 8), _mm256_set1_epi32(0xFF));
      b = _mm256_and_si256(b, _mm256_set1_epi32(0x7F));
      b = _mm256_slli_epi32(b, 7);

      vec c = _mm256_and_si256(_mm256_srli_epi32(chunk, 16), _mm256_set1_epi32(0xFF));
      c = _mm256_and_si256(c, _mm256_set1_epi32(0x7F));
      c = _mm256_slli_epi32(c, 14);

      vec d = _mm256_and_si256(_mm256_srli_epi32(chunk, 24), _mm256_set1_epi32(0xFF));
      d = _mm256_and_si256(d, _mm256_set1_epi32(0x7F));
      d = _mm256_slli_epi32(d, 21);

      vec m = _mm256_or_si256(a, _mm256_or_si256(b, _mm256_or_si256(c, d)));

      //print_epi32(m);

      _mm256_storeu_si256((vec *)dp, m);

      drem -= 8;
      dp += 8;
      srem -= 32;
      sp += 32;
    }
    else if ((mask & 0x6db6db) == 0X6db6db)
    { //1x(3 byte) seq
      //decompress_scalar(sp, dp, 0, 0, 24, 8);
      decompress3_8(sp, dp);
      sp += 24;
      srem -= 24;
      dp += 8;
      drem -= 8;
    }
    else if ((mask & 0x5555) == 0x5555)
    {
      vec a = _mm256_and_si256(chunk, _mm256_set1_epi16(0xFF));
      a = _mm256_and_si256(a, _mm256_set1_epi16(0x7F));

      vec b = _mm256_and_si256(_mm256_srli_epi16(chunk, 8), _mm256_set1_epi16(0xFF));
      b = _mm256_and_si256(b, _mm256_set1_epi16(0x7F));
      b = _mm256_slli_epi16(b, 7);

      vec m = _mm256_or_si256(a, b);

      //[L0,L1,L2,L3,R0,R1,R2,R3]
      a = _mm256_unpacklo_epi16(m, zero);
      //[L4,L5,L6,L7,R4,R5,R6,R7]
      b = _mm256_unpackhi_epi16(m, zero);

      //[R4,R5,R6,R7,L4,L5,L6,L7]
      m = _mm256_permutevar8x32_epi32(b, _mm256_set_epi32(3, 2, 1, 0, 7, 6, 5, 4));

      //[L0,L1,L2,L3,L4,L5,L6,L7]
      m = _mm256_blend_epi32(a, m, 1 << 7 | 1 << 6 | 1 << 5 | 1 << 4 | 0 << 3 | 0 << 2 | 0 << 1 | 0);

      _mm256_storeu_si256((vec *)dp, m); //
      sp += 16;
      srem -= 16;
      dp += 8;
      drem -= 8;

      if ((ushift(mask, 16) & 0x5555) == 0x5555) //2x(2 byte)
      {
        //[R0,R1,R2,R3,L0,L1,L2,L3]
        a = _mm256_permutevar8x32_epi32(a, _mm256_set_epi32(3, 2, 1, 0, 7, 6, 5, 4));

        //[R0,R1,R2,R3,R4,R5,R6,R7]
        m = _mm256_blend_epi32(a, b, 1 << 7 | 1 << 6 | 1 << 5 | 1 << 4 | 0 << 3 | 0 << 2 | 0 << 1 | 0);
        _mm256_storeu_si256((vec *)dp, m); //

        sp += 16;
        srem -= 16;
        dp += 8;
        drem -= 8;
      }
    }
    else if ((mask & 0xFF) == 0)
    {
      if (mask == 0)
      { //4x(1 byte) seq
        //TODO bounds checking after each store
        vec a = zero_extend(chunk, zero, idx_flip_0_0__4_1);
        _mm256_storeu_si256((vec *)dp, a);
        dp += 8;

        a = zero_extend(chunk, zero, idx_flip_0_2__4_3);
        _mm256_storeu_si256((vec *)dp, a);
        dp += 8;

        a = zero_extend(chunk, zero, idx_flip_0_4__4_5);
        _mm256_storeu_si256((vec *)dp, a);
        dp += 8;

        a = zero_extend(chunk, zero, idx_flip_0_6__4_7);
        _mm256_storeu_si256((vec *)dp, a);
        dp += 8;

        sp += 32;
        srem -= 32;
        drem -= 32;
      }
      else if ((ushift(mask, 8) & 0xFF) == 0)
      {
        if ((ushift(mask, 16) & 0xFF) == 0)
        { //3x(1 byte) seq
          //TODO bounds checking after each store
          vec a = zero_extend_bytes(chunk, 0);
          _mm256_storeu_si256((vec *)dp, a);
          dp += 8;

          a = zero_extend_bytes(chunk, 1);
          _mm256_storeu_si256((vec *)dp, a);
          dp += 8;

          a = zero_extend_bytes(chunk, 2);
          _mm256_storeu_si256((vec *)dp, a);
          dp += 8;

          sp += 24;
          drem -= 24;
          srem -= 24;
        }
        else
        { //2x(1 byte) seq
          vec a = zero_extend_bytes(chunk, 0);
          _mm256_storeu_si256((vec *)dp, a);
          dp += 8;

          a = zero_extend_bytes(chunk, 1);
          _mm256_storeu_si256((vec *)dp, a);
          dp += 8;

          sp += 16;
          srem -= 16;
          drem -= 16;
        }
      }
      else
      { //1x(1 byte seq)
        vec a = zero_extend_bytes(chunk, 0);
        _mm256_storeu_si256((vec *)dp, a);

        dp += 8;
        sp += 8;
        srem -= 8;
        drem -= 8;
      }
    }
    else
    {
      int moved = decompress_scalar(sp, dp, 0, 0, srem, 8);
      sp += moved;
      srem -= moved;
      drem -= 8;
      dp += 8;
    }
  }

  if (srem > 0 && drem > 0)
  {
    decompress_scalar(sp, dp, 0, 0, srem, drem);
  }

  return 0;
}

static void testIdenticalCategoryByteSeq(int base)
{
  int src[32];
  int rec[32];
  byte dst[5 * 32];

  int i = 0;
  for (; i < 32; i++)
  {
    src[i] = base + i;
  }

  compress(src, dst, 0, 0, 32);
  printf("---------------\n");

  decompress(dst, rec, 0, 0, 5 * 32, 32);

  for (i = 0; i < 32; i++)
  {
    int s = src[i];
    int d = rec[i];
    if (s != d)
    {
      printf("[V]Aborting. src[%d]=%d != rec[%d]=%d (diff=%d)\n", i, s, i, d, (int)(s - d));
      exit(EXIT_FAILURE);
    }
  }

  printf("[V]Decompress [%d,%d) success!\n", base, base + 32);

  memset(rec, 0, 32 * 4);
  decompress_scalar(dst, rec, 0, 0, 32 * 5, 32);

  for (i = 0; i < 32; i++)
  {
    int s = src[i];
    int d = rec[i];
    if (s != d)
    {
      printf("[S]Aborting. src[%d]=%d != rec[%d]=%d (diff=%d)\n", i, s, i, d, (int)(s - d));
      exit(EXIT_FAILURE);
    }
  }
  printf("[S]Decompress [%d,%d) success!\n", base, base + 32);
}

static void test1ByteCategory()
{
  testIdenticalCategoryByteSeq(0);
}

static void test2ByteCategory()
{
  testIdenticalCategoryByteSeq(0x80);
}

static void test3ByteCategory()
{
  testIdenticalCategoryByteSeq(0x4000);
}

static void test4ByteCategory()
{
  testIdenticalCategoryByteSeq(0x200000);
}

static void benchByCategory(int base, int n)
{
  int src[32];
  int rec[32];
  byte dst[5 * 32];

  int i = 0;
  for (; i < 32; i++)
  {
    src[i] = base + i;
  }

  clock_t t = clock();
  for (i = 0; i < n; i++)
  {
    compress(src, dst, 0, 0, 32);
  }
  t = clock() - t;
  double tcv = ((double)t) / CLOCKS_PER_SEC;

  t = clock();
  for (i = 0; i < n; i++)
  {
    decompress(dst, rec, 0, 0, 5 * 32, 32);
  }
  t = clock() - t;
  double tdv = ((double)t) / CLOCKS_PER_SEC;

  t = clock();

  for (i = 0; i < n; i++)
  {
    compress_scalar(src, dst, 32);
  }
  t = clock() - t;
  double tcs = ((double)t) / CLOCKS_PER_SEC;

  t = clock();

  for (i = 0; i < n; i++)
  {
    decompress_scalar(dst, rec, 0, 0, 32 * 5, 32);
  }
  t = clock() - t;
  double tds = ((double)t) / CLOCKS_PER_SEC;

  printf("{N:%d, V_C:%f, S_C:%f, V_D:%f, S_D:%f, C_R:%f, D_R:%f} \n", n, tcv, tcs, tdv, tds, tcs / tcv, tds / tdv);
}

static void runBenches()
{

  int j;

  printf("[%d,%d)-4x1 byte seq\n", 0, 0 + 32);
  for (j = 100000; j <= 100000 * 1000; j *= 10)
  {
    benchByCategory(0, j);
    printf("---------\n");
  }

  printf("[%d,%d)-2x2 byte seq\n", 0, 0 + 32);
  for (j = 100000; j <= 100000 * 1000; j *= 10)
  {
    benchByCategory(0x80, j);
    printf("---------\n");
  }

  printf("[%d,%d)-1x3 byte seq\n", 0x200000, 0x200000 + 32);
  for (j = 100000; j <= 100000 * 1000; j *= 10)
  {
    benchByCategory(0x4000, j);
    printf("---------\n");
  }

  printf("[%d,%d)-1x4 byte seq\n", 0x200000, 0x200000 + 32);
  for (j = 100000; j <= 100000 * 1000; j *= 10)
  {
    benchByCategory(0x200000, j);
    printf("---------\n");
  }
}

int main(char **args, int len)
{
  test1ByteCategory();
  test2ByteCategory();
  test3ByteCategory();
  test4ByteCategory();

  runBenches();
}