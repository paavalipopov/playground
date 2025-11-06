"""
Given the head of a linked list, rotate the list to the right by k places.
"""

# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

class Solution:
    def rotateRight(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        if k == 0 or head is None or head.next is None:
            return head

        buffer = []
        current = head
        while True:
            if len(buffer) == k+1:
                del buffer[0]
            buffer.append(current)

            if current.next is not None:
                current = current.next
            else:
                break
        
        if len(buffer) <= k:
            new_k = k % len(buffer)

            if new_k == 0:
                return head

            del buffer[0:-new_k-1]


        buffer[0].next = None
        new_head = buffer[1]
        buffer[-1].next = head

        return new_head




            
        