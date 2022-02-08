import yaml
amazon_intergation_key = "x-amazon-apigateway-integration"

ymal_markup_syntax = "$"+"{"+"}"


def praseSwaggerLambdaVariable(aws_url_paths):
    list_of_lambda_name = []
    for url_path in aws_url_paths:
        # print(url_method)
        for url_method in aws_url_paths[url_path]:
            method_detail = aws_url_paths[url_path][url_method]
            lambda_arn_name = method_detail[amazon_intergation_key]["uri"]
            lambda_arn_name = removeYmalMarkup(lambda_arn_name)
            list_of_lambda_name.append(lambda_arn_name)
    return list_of_lambda_name


def export(list_of_lambda_arn):
    for i in list_of_lambda_arn:
        print(i)
    print("--------")
    for i in list_of_lambda_arn:
        print(exportTerraformLambdaVariable(i)+"\n")


def removeYmalMarkup(text):
    for markup in ymal_markup_syntax:
        text = text.replace(markup, "")
    return text


def exportTerraformLambdaVariable(lambda_name):
    # export to terraform syntax
    text = '''variable {variable_name}'''.format(
        variable_name=lambda_name)
    text += "{\n"
    text += '''description = "{description}"'''.format(description=lambda_name)
    text += '\n}'
    return text


with open("./modules/gateway/course-app-swagger-apigateway.yaml", "r") as stream:
    try:
        data = yaml.safe_load(stream)
        # print(data["paths"])
        list_of_lambda_arn = praseSwaggerLambdaVariable(data["paths"])
        export(list_of_lambda_arn)
    except yaml.YAMLError as exc:
        print(exc)
