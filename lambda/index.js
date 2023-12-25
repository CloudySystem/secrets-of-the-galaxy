import { fetchJSONFromS3, updateSecretValue, getSecretValue } from './lib.js';

export const handler = async (event) => {
    const s3_event = event.Records[0].s3;
    const bucket = s3_event.bucket.name;
    const key = s3_event.object.key;
    const mission_id = process.env.mission_id;

    try {
        // Fetch Manifest JSON from S3 bucket
        let manifest = await fetchJSONFromS3(bucket, key);

        // If manifest contains target Jedi ID
        if (manifest.hasOwnProperty(mission_id)) {
            // Update Secret with new data
            await updateSecretValue(mission_id, manifest[mission_id]);

            // Log latest location update
            console.log(`Secret Data about Jedi ${mission_id}:`, manifest[mission_id]);
        } else {
            // Fetch Secret
            const response = await getSecretValue(mission_id);

            // Log latest location known
            console.log(`Secret Data about Jedi ${mission_id}:`, response);
        }
    } catch (error) {
        console.error("Lambda function encountered an error:", error);
        throw error;
    }
};
