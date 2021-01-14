import * as admin from 'firebase-admin';
import config from './../../config';

admin.initializeApp({
    credential: admin.credential.cert(config.cert as admin.ServiceAccount)
});

admin.firestore().settings({
    ignoreUndefinedProperties: true
});

import * as user from './onRequest/user';
exports.user = user;