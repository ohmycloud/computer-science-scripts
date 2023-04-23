from math import sqrt

class Point:
  def __init__(self, x, y):
    self.x = x
    self.y = y

  def area(self):
    return sqrt(self.x * self.x + self.y * self.y)

if __name__ == '__main__':
    p1 = Point(3, 4)
    print("p1 距离原点的距离等于 ", p1.area())
    p2 = Point(5, 12)
    print("p2 距离原点的距离等于 ", p2.area())