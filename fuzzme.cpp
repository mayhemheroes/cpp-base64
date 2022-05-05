#include "base64.h"
#include <iostream>

extern "C" int LLVMFuzzerTestOneInput(char* data, size_t size)
{
  std::string encoded = base64_encode(reinterpret_cast<const unsigned char*>(data), size);
  std::string decoded = base64_decode(encoded);
  return 0;
}
