#include "validate_id.h"
#include "ruby.h"
#include <stdbool.h>
#include <string.h>
#include <stddef.h>
#include "salesforce_id_ext.h"
#include "charmap.h"

const char VALID_CHARMAP[VALID_CHARMAP_SIZE] = {
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
  'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',

  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
  'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',

  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
};

static bool is_valid_char_for_id(char idChar);

// rb_sId MUST be a string
bool is_id_valid(VALUE rb_sId)
{
  unsigned long  id_size = 0;
           VALUE id      = rb_sId;
           char* cId     = NULL;

  id_size = RSTRING_LEN(id);

  if (id_size != SALESFORCE_ID_SENSITIVE_LENGTH &&
      id_size != SALESFORCE_ID_INSENSITIVE_LENGTH) return false;

  // XXX: Careful, cId is NOT NULL TERMINATED!
  //   Useful because it saves various allocations
  cId = RSTRING_PTR(rb_sId);

  for (unsigned long index = 0; index < id_size; ++index)
    if (!is_valid_char_for_id(cId[index])) return false;

  return true;
}

bool is_valid_char_for_id(char idChar)
{
  for (int index = 0; index < VALID_CHARMAP_SIZE; ++index)
    if (VALID_CHARMAP[index] == idChar) return true;

  return false;
}
