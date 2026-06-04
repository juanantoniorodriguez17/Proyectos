const express = require('express');//express sirve para crear un server y peticiones
const socketIo = require('socket.io');//aquí solo cargamos la paquetería

//Agregado nuevo
const Message = require('./src/modelos/messagemodel');
const mongoose = require('mongoose');
require('./config/database');
//Fin agregado nuevo

const app = express();
const http = require('http');
const server = http.createServer(app);//dentro del servidor estamos metiendo otro server
//indicamos que http usa las funciones de express (esclavo)
const io = socketIo(server, {//io contiene al server
    cors: {//para definir cualquier origen
        origin: "*",
    },
});

//(dy/dx) x+x^2y^3

app.use(express.static("public"));//"public" es la carpeta que tenemos en CHAT

//conexión del usuario
io.on ("connection", (socket) => {//el socket es para la conexión bidireccional
    console.log("Conexión exitosa", socket.id);//socketID indica quien se mete
    let username = "";

    socket.on("username", (name)=>{
        username = name;
        console.log(`El usuario ${username} se ha conectado`)//para mandar llamar una variable se usa $, se usa comilla invertida para detectar la variable
    });

    //Evento para obtener los mensajes
    // socket.on("message", (data)=>{
    //     if(data.username && data.message){// || significa or
    //         const timestamp = new Date().toLocaleTimeString;//se obtiene la fecha del mensaje
    //         const messageWithTime = {...data, timestamp};
    //         io.emit("message", messageWithTime);    
    //     }
    // });


//EVENTO REEMPLAZADO
    socket.on("message", async (data)=>{
        if(data.username && data.message){
            const timestamp = new Date();
            const newMessage = new Message({
                username: data.username,
                text: data.message,
                timestamp: timestamp,
            });
            try{
                //consttimemessageWithTime ={...data, timestamp};

                await newMessage.save();
                console.log("Mensaje guardado en la base de datos");
                io.emit("message",{username: data.username, message: data.message});
            }catch(err){
                console.error("Error al guardar el mensaje:",err);
            }
        }
    });


//Escuchar evento
    socket.on("istyping", (username) =>{
    // console.log("Escribiendo", username);
    socket.broadcast.emit("typing", username);
    //console.log("istyping, username");
    });
//CODIGO NUEVO//
    socket.on("disconnect",()=>{
        console.log("Usuario desconectado", socket.id);
    });
});

const PORT = process.env.PORT || 5000
server.listen(PORT, ()=>{
    console.log(`Servidor activo en el puerto http://localhost:${PORT}`)
});