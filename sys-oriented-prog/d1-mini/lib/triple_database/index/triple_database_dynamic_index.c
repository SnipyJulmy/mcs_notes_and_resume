//
// Created by snipy on 01.05.18.
//

#include "../../utils/debug.h"
#include "triple_database_dynamic_index.h"

/* Private definition */

// Index
static void __index_insert(DynamicIndex* self, Triplet* data);
static void __index_delete(DynamicIndex* self, Triplet* data);

// Node
static DynamicIndexNode* __insert(DynamicIndexNode* root, DynamicIndexNode* node);
static DynamicIndexNode* __grand_parent(DynamicIndexNode* self);
static DynamicIndexNode* __sibling(DynamicIndexNode* self);
static DynamicIndexNode* __uncle(DynamicIndexNode* self);
static bool __is_leaf(DynamicIndexNode* self);
static void __rotate_left(DynamicIndexNode** root, DynamicIndexNode* pt);
static void __rotate_right(DynamicIndexNode** root, DynamicIndexNode* pt);

// Utils
static void swap(COLOR* a, COLOR* b);

/* Constructors */

DynamicIndex* triple_database_dynamic_index_create()
{
    DynamicIndex* index = malloc(1 * sizeof(DynamicIndex));
    check_mem_and_return(index, NULL);

    index->insert = __index_insert;

    return index;
}

DynamicIndexNode* triple_database_dynamic_index_node_create(Triplet* data, uint32_t key)
{
    DynamicIndexNode* node = malloc(1 * sizeof(DynamicIndexNode));
    check_mem_and_return(node, NULL);

    // fields binding
    node->data = data;
    node->right = NULL;
    node->left = NULL;
    node->parent = NULL;
    node->color = RED;
    node->key = key;

    // methods binding
    node->sibling = __sibling;
    node->grand_parent = __grand_parent;
    node->uncle = __uncle;
    node->rotate_left = __rotate_left;
    node->rotate_right = __rotate_right;
    node->insert = __insert;
    node->is_leaf = __is_leaf;

    return node;
}

/* Private implementation */

// Index

static void __index_delete(DynamicIndex* self, Triplet* data)
{
    if (self->root == NULL) return;
    DynamicIndexNode* p = self->root;
}

// This function fixes violations caused by BST insertion
void __fix_violation(DynamicIndexNode* root, DynamicIndexNode* pt)
{
    DynamicIndexNode* parent_pt = NULL;
    DynamicIndexNode* grand_parent_pt = NULL;

    while ((pt != root) && (pt->color != BLACK) && (pt->parent->color == RED))
    {
        parent_pt = pt->parent;
        grand_parent_pt = pt->parent->parent;

        if (parent_pt == grand_parent_pt->left)
        {
            // Case : A
            // Parent of pt is left child of Grand-parent of pt

            DynamicIndexNode* uncle_pt = grand_parent_pt->right;
            // Case : 1
            // The uncle of pt is also red
            // Only Recoloring required
            if (uncle_pt != NULL && uncle_pt->color == RED)
            {
                grand_parent_pt->
                        color = RED;
                parent_pt->
                        color = BLACK;
                uncle_pt->
                        color = BLACK;
                pt = grand_parent_pt;
            }
            else
            {
                // Case : 2
                // pt is right child of its parent
                // Left-rotation required
                if (pt == parent_pt->right)
                {
                    parent_pt->rotate_left(&root, parent_pt);
                    pt = parent_pt;
                    parent_pt = pt->parent;
                }

                // Case : 3
                //  pt is left child of its parent
                // Right-rotation required
                grand_parent_pt->rotate_right(&root, grand_parent_pt);
                swap(&parent_pt->color, &grand_parent_pt->color);
                pt = parent_pt;
            }
        }
        else
        {
            // Case : B
            // Parent of pt is right child of Grand-parent of pt

            DynamicIndexNode* uncle_pt = grand_parent_pt->left;

            // Case : 1
            //    The uncle of pt is also red
            //    Only Recoloring required
            if ((uncle_pt != NULL) && (uncle_pt->color == RED))
            {
                grand_parent_pt->
                        color = RED;
                parent_pt->
                        color = BLACK;
                uncle_pt->
                        color = BLACK;
                pt = grand_parent_pt;
            }
            else
            {
                // Case : 2
                //  pt is left child of its parent
                //  Right-rotation required
                if (pt == parent_pt->left)
                {
                    parent_pt->rotate_right(&root, parent_pt);
                    pt = parent_pt;
                    parent_pt = pt->parent;
                }

                // Case : 3
                //  pt is right child of its parent
                // Left-rotation required
                grand_parent_pt->rotate_left(&root, grand_parent_pt);
                swap(&parent_pt->color, &grand_parent_pt->color);
                pt = parent_pt;
            }
        }
    }

    root->color = BLACK;
}

void swap(COLOR* a, COLOR* b)
{
    int t = *a;
    *a = *b;
    *b = t;
}

void __index_insert(DynamicIndex* self, Triplet* data)
{
    DynamicIndexNode* node = triple_database_dynamic_index_node_create(data, 0);
    check_mem_and_exit(node);
    self->root = node->insert(self->root, node);
    __fix_violation(self->root, node);
}

// Node

DynamicIndexNode* __insert(DynamicIndexNode* root, DynamicIndexNode* node)
{
    /* If the tree is empty, return a new node */
    if (root == NULL)
        return node;

    /* Otherwise, recur down the tree */
    if (node->data < root->data)
    {
        root->left = __insert(root->left, node);
        root->left->parent = root;
    }
    else if (node->data > root->data)
    {
        root->right = __insert(root->right, node);
        root->right->parent = root;
    }

    /* return the (unchanged) node pointer */
    return root;
}

DynamicIndexNode* __grand_parent(DynamicIndexNode* self)
{
    DynamicIndexNode* p = self->parent;
    if (p == NULL) return NULL;
    return p->parent;
}

DynamicIndexNode* __sibling(DynamicIndexNode* self)
{
    DynamicIndexNode* p = self->parent;
    if (p == NULL) return NULL;
    if (p->left == self) return p->right;
    return p->left;
}

DynamicIndexNode* __uncle(DynamicIndexNode* self)
{
    DynamicIndexNode* p = self->parent;
    if (self->grand_parent(self) == NULL)return NULL;
    return p->sibling(p);
}

void __rotate_left(DynamicIndexNode** root, DynamicIndexNode* pt)
{
    DynamicIndexNode* pt_right = pt->right;
    pt->right = pt_right->left;

    if (pt->right != NULL) pt->right->parent = pt;

    pt->right->parent = pt->parent;

    if (pt->parent == NULL)
        *root = pt_right;
    else if (pt == pt->parent->left)
        pt->parent->left = pt_right;
    else
        pt->parent->right = pt_right;

    pt_right->left = pt;
    pt->parent = pt_right;
}

void __rotate_right(DynamicIndexNode** root, DynamicIndexNode* pt)
{
    DynamicIndexNode* pt_left = pt->left;

    pt->left = pt_left->right;

    if (pt->left != NULL)
        pt->left->parent = pt;

    pt_left->parent = pt->parent;

    if (pt->parent == NULL)
        *root = pt_left;

    else if (pt == pt->parent->left)
        pt->parent->left = pt_left;

    else
        pt->parent->right = pt_left;

    pt_left->right = pt;
    pt->parent = pt_left;
}

static bool __is_leaf(DynamicIndexNode* self)
{
    return self->right == NULL && self->left == NULL;
}
