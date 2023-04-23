from typing import Union

def test(x: Union[str,int,float,]):
    print(x)

if __name__ == '__main__':
    test(1)
    test('str')
    test(3.1415926)