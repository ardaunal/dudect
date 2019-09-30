#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "random.h"
#include "dut.h"

const size_t chunk_size = 16;
const size_t number_measurements = 1e6; // per test

double do_one_computation(uint8_t *data) {
  //uint8_t secret[16] = {0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c};
  double sum = 0;
  double secret[16] = {0.7005506224295818, 0.2311519159462092, 0.5791342610766446, 0.30884780912632115, 0.31846249407420146, 0.06864319518425743, 0.525707856670509, 0.022520214334926014, 0.8272969825157204, 0.5588412201873573, 0.37502763199477407, 0.5979801029150054, 0.6856284772679532, 0.7864687333947685, 0.37162449812133913, 0.7057970574784226};
  for (size_t i=0; i < 16; ++i) {
    secret[i] = secret[i] * data[i];
    if (secret[i] != 0)
      sum += secret[i];
	else
      sum -= secret[i];
  }
  return sum;
}

void init_dut(void) {}

/*
 * This is a simple example on how good test vectors
 * accelerate leakage detection. The code below defines
 * two input classes:
 *  a) random input
 *  b) input fixed to 0
 *
 * This helps to detect timing leakage in do_one_computation()
 * above. The process is faster if the input is equal to the
 * `secret` variable inside do_one_computation(). In that case,
 * the timing difference is be much larger and hence more
 * easily detectable. Otherwise, the timing difference is still
 * detectable but more measurements are needed. (Try changing
 * the value of `secret` variable.)
 *
 * Morale: carefully crafted input vectors detect much faster
 * leakage (``whitebox'' testing).
 * 
 */
void prepare_inputs(uint8_t *input_data, uint8_t *classes) {
  randombytes(input_data, number_measurements * chunk_size);
  for (size_t i = 0; i < number_measurements; i++) {
    classes[i] = randombit();
    if (classes[i] == 0) {
      memset(input_data + (size_t)i * chunk_size, 0x00, chunk_size);
    } else {
      // leave random
    }
  }

//  for (size_t i = 0; i < number_measurements; ++i) {
//    classes[i] = randombit();
//    if (classes[i] == 0) {
//      memset(input_data + (int)((double)i * chunk_size), 0x00, chunk_size); 
//    } else {
//      printf("%f\n", (double)rand() / (double)RAND_MAX); 
//      memset(input_data + (int)((double)i * chunk_size), (double)rand() / (double)RAND_MAX, chunk_size);
//    }
//  } 
}
