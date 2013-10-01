import sys

def determine_column_widths(table, column_padding):
    columns = zip(*table)
    max_values = [max(col, key=len) for col in columns]
    return [len(x) + column_padding * 2 for x in max_values]

def gen_format(column_widths, divider):
    length_fmts = (
        '{:^' + str(width) + '}'
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
    '''Prints a table with the options listed above. Currently requires
    that the table contain only strings. Otherwise unexpected behavior will
    occur.
    '''

    if len(table) == 0:
        return

    column_widths = determine_column_widths(table, column_padding)
    fmt = gen_format(column_widths, divider)

    print_once = ['-' * x for x in column_widths] if has_header else None

    for row in table:
        fd.write(fmt.format(*row))
        if print_once is not None:
            fd.write(fmt.format(*print_once))
            print_once = None
