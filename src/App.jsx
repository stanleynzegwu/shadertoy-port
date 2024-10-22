import { Canvas } from "@react-three/fiber";
import ShaderPlane from "./canvas/ShaderPlane";

function App() {
  return (
    <div className="h-screen w-full fixed top-0 z-10">
      <Canvas>
        <ShaderPlane />
      </Canvas>
    </div>
  );
}

export default App;
