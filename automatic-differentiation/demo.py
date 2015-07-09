#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Code taken from a nice blog post by Tom Bowles:
# http://blog.tombowles.me.uk/2014/09/10/ad-algorithmicautomatic-differentiation

class ADForwardFloat(object):
    def __init__(self, val, delta):
        # The "actual" value (black square)
        self.val = val
        # The corresponding increment (blue square)
        self.delta = delta

    # Only implementing addition and multiplication here, and assuming
    # that both operands are always ADForwardFloats (no mixing AD and
    # ordinary floats). The formulae can be checked by working out the
    # Jacobian matrix of each function on paper.
    def __add__(self, other):
        # If F(x,y) = x + y, then J_F,x,y(delta_x, delta_y) = delta_y + delta_x
        return ADForwardFloat(self.val + other.val,
                              other.delta + self.delta)

    def __mul__(self, other):
        # If F(x,y) = x * y, then J_f,x,y(delta_x, delta_y) = y*delta_x + x*delta_y
        return ADForwardFloat(self.val * other.val,
                              other.val * self.delta + self.val * other.delta)

# Now let's implement a function of three variables: x^2 + xy + xz
def func1(x,y,z):
    return x * x + x * y + x * z

# Invoke the function with "ordinary" floats just gives us the result
print func1(3.0,4.0,5.0) # prints 36.0

# Now let's get the partial derivative of func1 with respect to x. To
# do this, we will need to pass in a unit vector pointing along the x
# axis as the increment for evaluating the Jaobian against, therefore
# we pass in 1 when creating the ADForwardFloat for x, and 0 for the
# others.
x = ADForwardFloat(3.0, 1.0)
y = ADForwardFloat(4.0, 0.0)
z = ADForwardFloat(5.0, 0.0)

result = func1(x,y,z)
print result.val # prints 36.0
print result.delta # prints 15.0, which is 2x+y+z
