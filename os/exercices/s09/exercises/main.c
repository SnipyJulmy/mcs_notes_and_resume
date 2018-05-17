#include <stdio.h>

int main()
{
    printf("Hello, World!\n");
    return 0;
}

void transaction(Account from, Account to, double amount)
{
    mutex lock1, lock2;
    lock1 = get_lock(from);
    lock2 = get_lock(to);

    acquire(lock1);
    acquire(lock2);

    withdraw(from, amount);
    deposit(to, amount);

    release(lock2);
    release(lock1);
}
void transaction(Account from, Account to, double amount)
{
    mutex lock1, lock2;
    lock1 = get_lock(from);
    lock2 = get_lock(to);

    acquire(lock1);
    withdraw(from, amount);
    release(lock1);

    acquire(lock2);
    deposit(to, amount);
    release(lock2);
}
