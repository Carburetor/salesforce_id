#include "charmap.h"
#include <ctype.h>

const char CHARMAP[CHARMAP_SIZE] = {
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
  'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5'
};

int charmap_index(const char character)
{
  char upped = toupper(character);

  for (int index = 0; index < CHARMAP_SIZE; ++index)
    if (CHARMAP[index] == upped) return index;

  return (-1);
}
