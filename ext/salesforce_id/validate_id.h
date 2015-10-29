#ifndef VALIDATE_SALESFORCE_ID_H
#define VALIDATE_SALESFORCE_ID_H 1

#include "ruby.h"
#include <stdbool.h>

#define VALID_CHARMAP_SIZE 62

extern const char VALID_CHARMAP[VALID_CHARMAP_SIZE];

bool is_id_valid(VALUE rb_sId);

#endif /* VALIDATE_SALESFORCE_ID_H */


