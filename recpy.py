def intersect(list_dat1, list_dat2):
    overlap = [i for i in list_dat1 if i in list_dat2]
    return overlap


def rec_int(list_dats):
    if len(list_dats) <= 2:
        return intersect(list_dats[0], list_dats[1])
    else:
        return intersect(list_dats[0], rec_int(list_dats[1:]))

