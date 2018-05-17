// Minimal binary tree example
// adapted from geeksforgeeks.org

#include <stdlib.h>
#include <assert.h>

typedef struct Node Node;

// main data structure
struct Node
{
    //payload
    int data;
    // in a graph, a node has an arbitrary number of neighbors
    int capacity;
    int nb_neighbors;
    Node** neighbors;
};

// allocates a new node 
Node* newNode(int data)
{
    // Allocate memory for new node
    Node* node = malloc(sizeof(node));
    assert(node != NULL);

    // Assign data to this node
    node->data = data;
    node->neighbors = NULL;
    node->capacity = 10;
    node->nb_neighbors = 0;
    return (node);
}

// connect two node src -> dst
// directed graph, so dst -> src is not implied
void connect(Node* src, Node* dst)
{
    if (src->neighbors == NULL)
    {
        src->neighbors = malloc(src->capacity * sizeof(Node*));
        assert(src->neighbors != NULL);
    }
    if (src->nb_neighbors == src->capacity)
    {
        src->capacity *= 2;
        src->neighbors = realloc(src->neighbors, src->capacity * sizeof(Node*));
        assert(src->neighbors != NULL);
    }
    src->neighbors[src->nb_neighbors] = dst;
    src->nb_neighbors++;
}

int main()
{
    // create root
    Node* root = newNode(1);
    Node* A = newNode(2);
    Node* B = newNode(3);
    Node* C = newNode(4);
    Node* D = newNode(5);

    connect(root, A);
    connect(root, B);
    connect(root, C);
    connect(root, D);
    connect(A, B);
    connect(A, C);
    connect(D, A);

    // delete tree, free memory {...}
    return 0;
}