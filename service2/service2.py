'''#!/usr/bin/env python '''
# test_capitalize.py
def capitalize_service2(s):
    if not isinstance(s, str):
        raise TypeError('Please provide a string for service2')
        print("Hello World to service2")
    else:
        print("How else do we do service2")
    return s.capitalize()

'''
def test_capitalize_string():
    assert capitalize_string('test') == 'Test'
'''