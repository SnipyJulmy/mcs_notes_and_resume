// A simple stack implementation
// backed by a linked list
// adapted from geeksforgeeks.org

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
 
// main structure to represent the stack
struct StackNode
{
    int data; // payload hard-coded to int
    struct StackNode* next;
};
 
struct StackNode* newNode(int data)
{
    struct StackNode* stackNode = (struct StackNode*) malloc(sizeof(struct StackNode));
    if(stackNode == NULL)
    {
        // failed to allocate memory
        fprintf(stderr, "Couldn't allocate memory\n");
        exit(1);
    }
    stackNode->data = data;
    stackNode->next = NULL;
    return stackNode;
}
 
int isEmpty(struct StackNode *root)
{
    return !root;
}

// we want to be able to modify the root variable. 
// To do this, we must pass a pointer to the pointer variable 
// (a double pointer) so we will be able to modify the pointer itself
void push(struct StackNode** root, int data)
{
    struct StackNode* stackNode = newNode(data);
    stackNode->next = *root;
    *root = stackNode;
    printf("%d pushed to stack\n", data);
}
 
int pop(struct StackNode** root)
{
    if (isEmpty(*root))
    {
        // stack was empty!
        fprintf(stderr, "Popped an empty stack\n");
        exit(2);
    }
    struct StackNode* temp = *root;
    *root = (*root)->next;
    int popped = temp->data;
    free(temp);
    printf("%d popped from stack\n", popped);
    return popped;
}
 
int peek(struct StackNode* root)
{
    if (isEmpty(root))
    {
        printf("stack is empty\n");
        return INT_MIN;
    }
    printf("%d peeked from stack\n", root->data);
    return root->data;
}
 
int main()
{
    struct StackNode* root = NULL;
 
    peek(root);
    push(&root, 10);
    push(&root, 20);
    push(&root, 30);
    pop(&root);
    peek(root);
 
    return 0;
}