import { GetObjectCommand, S3Client } from "@aws-sdk/client-s3";
import { UpdateSecretCommand, SecretsManagerClient, GetSecretValueCommand } from "@aws-sdk/client-secrets-manager";

const s3_client = new S3Client({region: process.env.region});
const secrets_client = new SecretsManagerClient({region: process.env.region});

async function fetchJSONFromS3(bucket, key) {
    try {
        const command = new GetObjectCommand({Bucket: bucket, Key: key});
        const response = await s3_client.send(command);
        const body = await response.Body.transformToString();
        return JSON.parse(body);
    } catch (error) {
        console.error(`Error fetching object ${key} from S3 bucket ${bucket}:`, error);
        throw error;
    }
};

async function updateSecretValue(secret_name, secret_data) {
    try {
        const command = new UpdateSecretCommand({
            SecretId: secret_name,
            SecretString: JSON.stringify(secret_data)
        });
        return await secrets_client.send(command);
    } catch (error) {
        console.error(`Error getting secret ${secret_name} from Secrets Manager:`, error);
        throw error;
    }
}

async function getSecretValue(secret_name) {
    try {
        const command = new GetSecretValueCommand({ SecretId: secret_name });
        const response = await secrets_client.send(command);
        if (response.SecretString) {
            return response.SecretString;
        }
        if (response.SecretBinary) {
            return response.SecretBinary;
        }
    } catch (error) {
        console.error(`Error getting secret ${secret_name} from Secrets Manager:`, error);
        throw error;
    }
}

export {
    fetchJSONFromS3,
    updateSecretValue,
    getSecretValue
}
