#include "sensitive_to_insensitive.h"
#include "ruby.h"
#include <stddef.h>
#include <string.h>
#include <stdint.h>
#include <ctype.h>
#include "salesforce_id_ext.h"
#include "charmap.h"

static void append_casing_hash(char* id);
static char char_from_chunk(char* id, size_t chunk);

// rb_sId MUST be a string and of size 15
VALUE sensitive_to_insensitive(VALUE rb_sId)
{
  const int   id_size = SALESFORCE_ID_SENSITIVE_STRING_LENGTH;
        char* id      = StringValueCStr(rb_sId);
        char  new_id[SALESFORCE_ID_INSENSITIVE_STRING_LENGTH] = {0};

  memcpy(new_id, id, sizeof(char) * id_size);
  append_casing_hash(new_id);

  return rb_str_new2(new_id);
}

void append_casing_hash(char* id)
{
  const int    insensitive_index = SALESFORCE_ID_SENSITIVE_LENGTH;
  const size_t chunks            = 3u;
        char   hash[3]           = {'\0', '\0', '\0'};

  for (size_t chunk = 0u; chunk < chunks; ++chunk)
    hash[chunk] = char_from_chunk(id, chunk);

  id[insensitive_index]     = hash[0];
  id[insensitive_index + 1] = hash[1];
  id[insensitive_index + 2] = hash[2];
}

// Chunk must be within 0 and 2
char char_from_chunk(char* id, size_t chunk)
{
  const size_t  chars_per_chunk = 5u;
        uint8_t map_index       = 0u;

  for (size_t index = 0u; index < chars_per_chunk; ++index)
  {
    char current = id[(chars_per_chunk * chunk) + index];

    if (isupper(current)) map_index = (map_index | (1u << index));
  }

  return CHARMAP[map_index];
}
