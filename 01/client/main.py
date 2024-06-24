from fastapi import FastAPI
import grpc
import service_pb2
import service_pb2_grpc

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/health")
def health_check():
    try:
        with grpc.insecure_channel('grpc-server:50051') as channel:
            stub = service_pb2_grpc.MyServiceStub(channel)
            response = stub.GetMessage(service_pb2.MessageRequest(name='Health Check'))
            if response.message:
                return {"status": "ok", "message": "Connection to gRPC server is healthy"}
            else:
                return {"status": "error", "message": "Unexpected response from gRPC server"}
    except Exception as e:
        return {"status": "error", "message": f"Error connecting to gRPC server: {str(e)}"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
