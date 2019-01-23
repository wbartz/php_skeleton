<?php

namespace App\Http\Controllers;

use App\Models\Usuarios;
use Illuminate\Http\Request;
use Laravel\Lumen\Routing\Controller as BaseController;

class UsuariosController extends BaseController
{
    public function getAll()
    {
        return response()->json(Usuarios::all());
    }

    public function getUser(int $id)
    {
        return response()->join(Usuarios::find($id));
    }

    public function create(Request $request)
    {
        $this->validate($request, [
            'login' => 'required|unique:usuarios',
            'nome' => 'required',
            'email' => 'required|email|unique:usuarios',
            'senha' => 'required|min:6',
        ]);

        $usuario = Usuarios::create($request->all());

        return response()->json($usuario, 201);
    }

    public function update(int $id, Request $request)
    {
        $usuario = Usuarios::findOrFail($id);
        $usuario->update($request->all());

        return response()->json($usuario, 200);
    }

    public function delete(int $id)
    {
        Usuarios::findOrFail($id)->delete();

        return response('Usuário deletado com sucesso!', 200);
    }
}
