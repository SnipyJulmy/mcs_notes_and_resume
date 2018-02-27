//
// Created by snipy on 27.02.18.
//

enum {FALSE, TRUE} b; // declaration of variable b, without tag
enum color_tag {RED, GREEN, BLUE}; // enum declaration,
// with tag 'color_tag'
enum color_tag c1, c2, c3; // declaration of variables ci

void main(void)
{
    b = TRUE;
    printf("%i %i\n", b, FALSE);
    c1 = RED; c2 = c1+1; c3 = BLUE;
    printf("%i %i %i\n", c1, c2, c3);
}

