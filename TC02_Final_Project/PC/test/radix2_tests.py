import numpy as np
from numpy.testing import assert_equal
from dwht import radix2

def test_radix2_base():
    x = np.array([1, 2])
    expected = np.array([3, -1])
    assert_equal(radix2(x), expected)

def test_radix2_even():
    x = np.array([1, 2, 3, 4])
    expected = np.array([4, 6, -2, -2])
    assert_equal(radix2(x), expected)

def test_radix2_odd():
    x = np.array([1, 2, 3, 4, 5])
    expected = np.array([4, 6, 5, -2, -2])
    assert_equal(radix2(x)[:len(expected)], expected)