'''#!/usr/bin/env python '''
# test_capitalize.py
def capitalize_string(s):
    if not isinstance(s, str):
        raise TypeError('Please provide a string')
        print("Hello World")
    else:
        print("How else")
    return s.capitalize()

'''
def test_capitalize_string():
    assert capitalize_string('test') == 'Test'
'''