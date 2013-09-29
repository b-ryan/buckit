import sys

def determine_column_widths(table):
    columns = zip(*table)
    max_values = [max(col, key=len) for col in columns]
    return [len(x) for x in max_values]

def gen_format(column_widths, divider, column_padding):
    length_fmts = (
        '{:^' + str(width + column_padding * 2) + '}'
        for width in column_widths
    )
    mid = divider.join(length_fmts)
    return '{divider}{mid}{divider}\n'.format(
        divider=divider,
        mid=mid,
    )

def p(table,
        fd=sys.stdout,
        divider='|',
        column_padding=1,
        has_header=True):

    if len(table) == 0:
        return

    column_widths = determine_column_widths(table)
    fmt = gen_format(column_widths, divider, column_padding)

    if has_header:
        print_once = ['-' * x for x in column_widths]

    for row in table:
        fd.write(fmt.format(*row))
        if print_once is not None:
            fd.write(fmt.format(*print_once))
            print_once = None
