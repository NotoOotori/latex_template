''' test.py '''
def cxy_distance_to_1(point):
    ''' Return the point's distance to 1. '''
    if point <= 0:
        raise ValueError()
    return abs(point - 1) if point >= 1 else abs(1/point - 1)

def main():
    ''' The main function. '''
    array = [10, 2]
    for i in range(100):
        array.append(2/(array[i] + array[i + 1]))
        print('a[{}] = {}; distance = {}.'.format(
            i + 2, array[i + 2], cxy_distance_to_1(array[i + 2])))

if __name__ == '__main__':
    main()
