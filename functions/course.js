const AWS = require("aws-sdk");
const ddb = new AWS.DynamoDB.DocumentClient({ region: "ap-southeast-1" });
exports.handler = async (event) => {

    // TODO implement

    // event['path'] -- for get path url

    let response;
    if (event.httpMethod == "GET") {
        response = getAllCourse();
    }
    else if (event.httpMethod == "POST") {
        let reqBody = JSON.parse(event.body);
        response = addCourse(reqBody);
    }
    return response;
};

// method function
async function addCourse(course) {
    let param = {
        TableName: "course",
        Item: course
    };
    return await ddb.put(param).promise().then(() => {
        return buildReponse(200, "OK")
    });
}

// service
async function getAllCourse() {
    let param = {
        TableName: "course",
    }
    return await ddb.scan(param, []).promise().then((value) => {
        return buildReponse(200, JSON.stringify(value));
    })

}

function getCourseDetail() { }

function getCourseDetail() { }

function getCourseListTitle() { }


// help function
function buildReponse(statusCode, body) {
    return {
        statusCode: 200,
        headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": true
        },
        body: body,
    }
}
