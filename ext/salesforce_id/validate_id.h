#ifndef VALIDATE_SALESFORCE_ID_H
#define VALIDATE_SALESFORCE_ID_H 1

#include "ruby.h"
#include <stdbool.h>

bool is_id_valid(VALUE rb_sId);
bool has_valid_characters(VALUE id);

#endif /* VALIDATE_SALESFORCE_ID_H */


