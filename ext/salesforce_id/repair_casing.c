#include "repair_casing.h"
#include "ruby.h"
#include <stddef.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>
#include "salesforce_id.h"
#include "charmap.h"

static void chunk_casing(const char character, bool* casing);

void repair_casing(char* id)
{
  const int    chunk_index         = SALESFORCE_ID_SENSITIVE_LENGTH;
  const size_t casing_size         = 15u;
        bool   casing[casing_size] = {false};

  chunk_casing(id[chunk_index], casing);
  chunk_casing(id[chunk_index + 1], &casing[5]);
  chunk_casing(id[chunk_index + 2], &casing[10]);

  for (size_t index = 0u; index < casing_size; ++index)
  {
    if (casing[index])
      id[index] = toupper(id[index]);
    else
      id[index] = tolower(id[index]);
  }

  id[chunk_index]     = toupper(id[chunk_index]);
  id[chunk_index + 1] = toupper(id[chunk_index]);
  id[chunk_index + 2] = toupper(id[chunk_index]);
}

// Casing is an array of size 5
void chunk_casing(const char character, bool* casing)
{
  size_t casing_size = 5u;
  int    map_index   = charmap_index(character);

  if (map_index < 0)
  {
    rb_raise(rb_eArgError, "Salesforce ID contains invalid character");
    return;
  }

  for (size_t bit_index = 0u; bit_index < casing_size; ++bit_index)
    casing[bit_index] = (map_index & (1u << bit_index)) != 0u;
}
