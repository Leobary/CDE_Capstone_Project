# A function to extract the required columns from the raw data
def extract_country_info(data):
    country_info = {}

    country_info['country_name'] = data['name']['common']
    country_info['independence'] = data['independent']
    country_info['united_nation_members'] = data['unMember']
    country_info['startOfWeek'] = data['startOfWeek']
    country_info['official_country_name'] = data['name']['official']

    if data.get('name') and data['name'].get('nativeName'):
        native_names = list(data['name']['nativeName'].keys())[0]
        country_info['common_native_name'] = \
            data['name']['nativeName'].get(native_names, {})\
            .get('common', 'Unknown')
    else:
        country_info['common_native_name'] = 'Unknown'

    currencies = data.get('currencies', {})
    if isinstance(currencies, dict) and currencies:
        # Check if the currency code exists in the dictionary
        # Get the first currency code
        currency_code = list(currencies.keys())[0]
        country_info['currency_code'] = currency_code
        currency_info = currencies.get(currency_code, {})

        if isinstance(currency_info, dict):
            country_info['currency_name'] = \
                    currency_info.get('name', 'Unknown')
            country_info['currency_symbol'] = \
                currency_info.get('symbol', 'Unknown')
        else:
            country_info['currency_name'] = 'Unknown'
            country_info['currency_symbol'] = 'Unknown'
    else:
        country_info['currency_name'] = 'Unknown'
        country_info['currency_symbol'] = 'Unknown'
        currency_code = 'Unknown'

    if 'idd' in data:
        idd = data['idd']
        # Ensure 'suffixes' is an iterable (e.g., list or tuple) before joining
        suffixes = idd.get('suffixes', [])
        # Ensure suffixes is a valid iterable
        if isinstance(suffixes, (list, tuple)):
            country_info['country_code'] = \
                "{}{}".format(idd.get('root', ''),
                              ''.join(str(s) for s in suffixes))
            # country_info['country_code'] = idd.get('root', '')
            # + ''.join(str(s) for s in suffixes)
        else:
            # If suffixes is not iterable, only take 'root'
            country_info['country_code'] = idd.get('root', '')
    else:
        country_info['country_code'] = 'Unknown'

    if isinstance(data.get('capital'), (str, list)):
        # If capital is a list, take the first element;
        # if it's a string, use it directly
        country_info['capital'] = data['capital'][0] \
            if isinstance(data['capital'], list) else data['capital']
    else:
        country_info['capital'] = 'Unknown'

    country_info['region'] = data['region']
    country_info['sub_region'] = data['subregion']

    languages = data.get('languages')
    if isinstance(languages, dict):
        # Join language values, ensuring they are all strings
        # and filtering out None values
        country_info['languages'] = ', '.join(str(lang)
                                              for lang in languages.values()
                                              if lang is not None)
    else:
        country_info['languages'] = 'Unknown'

    country_info['area'] = data['area']
    country_info['population'] = data['population']
    country_info['continents'] = data['continents'][0]

    return country_info
