#include <stdio.h>
#include <stdlib.h>
#include <immintrin.h>
#include <stdint.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>     /* strtol */
#include <time.h>

typedef char byte;
typedef __m256i vec;

#define min(a,b) a<b?a:b
#define ALL_GT(X,Y) _mm256_movemask_epi8(_mm256_cmpgt_epi32(Y,X))
#define CHUNK_SIZE_BITS 256
#define CHUNK_SIZE_BYTE 32
#define CHUNK_SIZE_INT 8

#define cast_int_to_byte(X) _mm256_and_si256(X,_mm256_set1_epi32(0xFF))
#define left_shift_one(X) _mm256_and_si256(_mm256_slli_epi16(X,8),_mm256_set1_epi8(0xFF))
#define left_shift_two(X) _mm256_and_si256(_mm256_slli_epi32(X,16),_mm256_set1_epi8(0xFF))
#define left_shift_three(X) _mm256_and_si256(_mm256_slli_epi32(X,24),_mm256_set1_epi8(0xFF))
#define  ushift(a,n) (int) ( ((unsigned int)a) >> n)


#define zero_extend(X,Z,M)\
 _mm256_unpacklo_epi8(_mm256_unpacklo_epi8(_mm256_permutevar8x32_epi32(X,M),Z),Z)

#define zero _mm256_set1_epi64x(0)
#define idx_permute8x32 _mm256_set_epi32(1,1,1,1,1,1,4,0)
#define idx_flip_0_0__4_1 _mm256_set_epi32(0,0,0,1,0,0,0,0)
#define idx_flip_0_2__4_3 _mm256_set_epi32(0,0,0,3,0,0,0,2)
#define idx_flip_0_4__4_5 _mm256_set_epi32(0,0,0,5,0,0,0,4)
#define idx_flip_0_6__4_7 _mm256_set_epi32(0,0,0,7,0,0,0,6)
#define idx_permute4x64  (0x3<<6|0x3<<4|0x2<<2|0)
#define byte1_test _mm256_set1_epi32(0x80)
#define byte2_test _mm256_set1_epi32(0x4000)
#define byte3_test _mm256_set1_epi32(0x200000)
#define byte4_test _mm256_set1_epi32(0x10000000)
#define _0x7F _mm256_set1_epi8(0x7F)
#define _0x80 _mm256_set1_epi8(0x80)


static inline vec zero_extend_bytes(vec v,int ix){

  vec rv; 

  switch(ix){
    case 0:
      rv = _mm256_permutevar8x32_epi32(v,idx_flip_0_0__4_1);
      break;
    case 1:
      rv = _mm256_permutevar8x32_epi32(v,idx_flip_0_2__4_3);
      break;
    case 2:
      rv = _mm256_permutevar8x32_epi32(v,idx_flip_0_4__4_5);
      break;
    case 3:
      rv = _mm256_permutevar8x32_epi32(v,idx_flip_0_6__4_7);
      break;
    default:
      break; 
  }

 
  rv = _mm256_unpacklo_epi8(rv,zero);  
  rv = _mm256_unpacklo_epi8(rv,zero);

  return rv;
}

static void print_epi8_128(vec v){
  char* t = (char*)&v;
  int i;
  printf("[");
  for(int i=0;i<16;i++){
    if(i>0 && i%4==0){
      printf(";"); 
    }
    char p = t[i];
    printf("{%d}",(int) (p&0xFF)); 
  }
  printf("]\n");
}

static void print_epi8(vec v){
  char* t = (char*)&v;
  int i;
  printf("[");
  for(int i=0;i<32;i++){
    if(i>0 && i%4==0){
      printf(";"); 
    }
    char p = t[i];
    printf("{%d}",(int) (p&0xFF)); 
  }
  printf("]\n");
}


static void print_epi32_tuple(vec v){
  int* t = (int*)&v;
  int i;
  printf("[");
  for(int i=0;i<8;i++){
    int p = t[i];
    printf("{%d,%d,%d,%d}",(int)((p>>24) &0xFF),(int) ((p>>16)&0xFF),(int) ((p>>8)&0xFF),(int) (p&0xFF)); 
    if(i<7){
      printf(";"); 
    }
  }
  printf("]\n");
}

static void print_epi32(vec v){
  int* t = (int*)&v;
  int i;
  printf("[");
  for(int i=0;i<8;i++){
    int p = t[i];
    printf("{%d}",p); 
    if(i<7){
      printf(";"); 
    }
  }
  printf("]\n");
}
