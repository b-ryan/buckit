import sys

def determine_column_widths(table, column_padding):
    columns = zip(*table)
    max_values = [max(col, key=len) for col in columns]
    return [len(x) + column_padding * 2 for x in max_values]

def create_full_row_fmt(divider, width_fmts):
    return '{0}{1}{0}\n'.format(divider, divider.join(width_fmts))

def p(table,
        fd=sys.stdout,
        column_padding=1,
        has_header=True):

    if len(table) == 0:
        return

    stringified = [map(str, row) for row in table]
    column_widths = determine_column_widths(stringified, column_padding)
    width_fmts = ['{:^' + str(width) + '}' for width in column_widths]
    border_vals = ['-' * x for x in column_widths] if has_header else None

    border_fmt = create_full_row_fmt('*', width_fmts)
    row_fmt = create_full_row_fmt('|', width_fmts)

    print_border = lambda: fd.write(border_fmt.format(*border_vals))
    print_border()

    is_header = True
    for row in stringified:
        fd.write(row_fmt.format(*row))

        if has_header and is_header:
            print_border()
            is_header = False

    print_border()
