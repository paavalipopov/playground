"""
There is a robot on an m x n grid. The robot is initially located at the top-left corner (i.e., grid[0][0]). The robot tries to move to the bottom-right corner (i.e., grid[m - 1][n - 1]). The robot can only move either down or right at any point in time.

Given the two integers m and n, return the number of possible unique paths that the robot can take to reach the bottom-right corner.

The test cases are generated so that the answer will be less than or equal to 2 * 109.
"""

class Solution:
    def uniquePaths(self, m: int, n: int) -> int:

        n = int(self.factorial(m+n-2)/(self.factorial(m-1)*self.factorial(n-1)))

        # n = self.recursion(m, n)

        return n

    def factorial(self, n):
        if n == 1 or n == 0:
            return 1
        return n * self.factorial(n-1)

    # def recursion(self, m, n):
    #     if m == 1 or n == 1:
    #         return 1
    #     else:
    #         return self.recursion(m-1, n) + self.recursion(m, n-1)
    