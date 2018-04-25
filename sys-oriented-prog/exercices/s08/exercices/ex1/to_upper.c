#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

char* to_upper_a(char* string)
{
    for (int i = 0; i < strlen(string); i++)
    {
        string[i] = (char) toupper(string[i]);
    }
    return string;
}

char* to_upper_b(char* string)
{
    char* start = string;
    while (*string != '\0')
    {
        if (*string >= 'a' && *string <= 'z')
            *string += ('A' - 'a');
        string++;
    }
    return start;
}

int main(void)
{
    char* a = malloc(4 * sizeof(char));
    strcpy(a, "asd");
    assert(strcmp(to_upper_a(a), "ASD") == 0);
    strcpy(a, "asd");
    assert(strcmp(to_upper_b(a), "ASD") == 0);
    return EXIT_SUCCESS;
}

