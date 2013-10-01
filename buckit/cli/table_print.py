import sys

def determine_column_widths(table, column_padding):
    columns = zip(*table)
    max_values = [max(col, key=len) for col in columns]
    return [len(x) + column_padding * 2 for x in max_values]

def create_full_row_fmt(divider, width_fmts):
    return '{0}{1}{0}\n'.format(divider, divider.join(width_fmts))

def p(table, header=None,
        fd=sys.stdout,
        column_padding=1):

    if len(table) == 0:
        return

    table = [map(str, row) for row in table]
    full_table = ([header] if header is not None else []) + table

    column_widths = determine_column_widths(full_table, column_padding)
    width_fmts = ['{:^' + str(width) + '}' for width in column_widths]
    border_vals = ['-' * x for x in column_widths]

    border_fmt = create_full_row_fmt('*', width_fmts)
    row_fmt = create_full_row_fmt('|', width_fmts)

    print_border = lambda: fd.write(border_fmt.format(*border_vals))
    print_row = lambda row: fd.write(row_fmt.format(*row))

    print_border()

    if header is not None:
        print_row(header)
        print_border()

    [print_row(row) for row in table]
    print_border()
