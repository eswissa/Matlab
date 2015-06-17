function conn = connectToScoop()

%create a connection to the server
javaaddpath([matlabroot,'/java/jarext/postgresql-9.3-1100.jdbc4.jar'])
conn = database('ScoopPostgreSQLTest','ufprv1c1frtk21','p6dojm5c49oetl4hl14376qkt9','org.postgresql.Driver','jdbc:postgresql://ec2-54-227-246-90.compute-1.amazonaws.com:5572/dddim6es4l7kms?tcpKeepAlive=true&ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory&');

%
%Simple example
%curs = exec(conn,'SELECT ALL January FROM salesVolume');
end