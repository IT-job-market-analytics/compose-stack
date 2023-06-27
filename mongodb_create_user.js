db.getSiblingDB('admin').auth(
    process.env.MONGO_INITDB_ROOT_USERNAME,
    process.env.MONGO_INITDB_ROOT_PASSWORD
);

analyticsDb = db.getSiblingDB(process.env.MONGO_DATABASE);

a = analyticsDb.createUser({
    user: process.env.MONGO_USER,
    pwd: process.env.MONGO_PASSWORD,
    roles:
        [
            {
                role: "dbAdmin",
                db: process.env.MONGO_DATABASE
            },
            {
                role: "readWrite",
                db: process.env.MONGO_DATABASE
            }
        ]
});
