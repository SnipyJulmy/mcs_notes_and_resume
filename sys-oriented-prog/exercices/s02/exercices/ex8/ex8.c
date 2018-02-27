//
// Created by snipy on 27.02.18.
//

void main(void)
{
    int p;
    int q;

    int r1,r2,r3;

    r1 = p || !q;                   //(1)
    r2 = p && (p == q);             // Beware: p == q
    r3 = p && (p = q) || (p = !q);  // Beware: p = q
}