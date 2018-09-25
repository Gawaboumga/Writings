def memory_consumption(N, k, w):
    inode = 0
    for i in range(1, w - 1, k + 1):
        inode += min(next_power_of_2(N), 2 ** i)
    return 2 * ((key size + 2 ** k * key size) * inode \
        + next_power_of_2(N) * (key size + value size))