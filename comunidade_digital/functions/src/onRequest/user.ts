import * as functions from 'firebase-functions'
import * as admin from 'firebase-admin'
const cors = require('cors')({origin: true});

export const getUserData = functions.https.onRequest((request, response) => {
    return cors(request, response, async () => {
        const db = admin.firestore();
        let uid = request.body.uid;
        return await db.collection("user").doc(uid).get().then(doc => {
            return response.status(200).send(doc.data());
        }).catch((error) => {
            return response.status(200).send(null);
        });
    });
});

export const createUser = functions.https.onRequest((request, response) => {
    return cors(request, response, async () => {
        const db = admin.firestore();
        let uid = request.body.uid;
        let ref = uid ? await db.collection("user").doc(uid) : await db.collection("user").doc();
        let userData = {
            "cpf": request.body.cpf,
            "email": request.body.email,
            "cep": request.body.cep,
            "logradouro": request.body.logradouro,
            "bairro": request.body.bairro,
            "localidade": request.body.localidade,
            "uf": request.body.uf,
            "ibge": request.body.ibge,
            "homeNumber": request.body.homeNumber,
            "photoURL": request.body.photoURL,
            "created": new Date()
        };
        await ref.set(userData);
        return response.status(200).send(userData);
    });
});