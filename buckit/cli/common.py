class CliException(Exception):
    pass

def search_by_name(session, model, name):
    result = session.query(model).filter_by(name=name).first()
    if result is not None:
        return result
    raise CliException('Unknown: ' + name)
