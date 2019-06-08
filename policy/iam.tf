resource "aws_iam_role" "api-gateway" {
  name = "Default_API"
  assume_role_policy = "${file("./policy/iam_assumeapi.json")}"
}

resource "aws_iam_role_policy_attachment" "api-gateway-attach" {
  role       = "${aws_iam_role.api-gateway}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_iam_role" "lambda-default" {
  name               = "Lambda_Basic"
  assume_role_policy = "${file("./policy/iam_assumelambda.json")}"
}

resource "aws_iam_role_policy_attachment" "lambda-default-attach" {
  role       = "${aws_iam_role.lambda-default}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "lambda-dynamodb" {
  name = "Lambda_DynamoDB"
  assume_role_policy = "${file("./policy/iam_assumelambda.json")}"
}

resource "aws_iam_policy" "lambda-dynamodb" {
  name = "Lambda_DynamoDB"
  policy = "${file("./policy/Lambda_Readnly_DynamoDB.json")}"
}

resource "aws_iam_role_policy_attachment" "lambda-dynamodb-basic-attach" {
  role       = "${aws_iam_role.lambda-dynamodb}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda-dynamodb-read-attach" {
  role       = "${aws_iam_role.lambda-dynamodb}"
  policy_arn = "${aws_iam_policy.lambda-dynamodb.arn}"
}
