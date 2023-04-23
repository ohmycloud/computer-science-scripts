# -*- encoding: utf-8 -*-

import argparse

if __name__=='__main__':
    parser = argparse.ArgumentParser(description="the command line args parser")
    parser.add_argument('--shape', type=str, default=None, required=True, choices=["rectangle","triangle"], help='the shape you picked')
    parser.add_argument('--color', type=str, default=None, required=True, choices=['yellow', 'red'], help='the color you picked')
    args = parser.parse_args()

    print("you picked a shape of {}".format(args.shape))
    print("you picked a color of {}".format(args.color))

