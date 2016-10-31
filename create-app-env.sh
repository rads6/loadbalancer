o " creating database instance"
#Creating database subnet group
#aws rds create-db-subnet-group --db-subnet-group-name ITMO544-rg-subnet-group --db-subnet-group-description "subnet group for rg" --subnet-ids subnet-cf82a1ab

#Creating database instance
aws rds create-db-instance --db-name radsrecords --db-instance-identifier rg-db --db-instance-class db.t1.micro --engine MySQL --master-username controller1 --master-user-password mastirg_6 --allocated-storage 5 --vpc-security-group-ids sg-1db27864 --publicly-accessible --port 3306 --allocated-storage 5


echo "Please wait until the database instance is available. This might take a lot of time."
aws rds wait db-instance-available --db-instance-identifier rg-db


#Creating a read replica
#aws rds create-db-instance-read-replica --db-instance-identifier rg-db-read --source-db-instance-identifier rg-db --publicly-accessible

