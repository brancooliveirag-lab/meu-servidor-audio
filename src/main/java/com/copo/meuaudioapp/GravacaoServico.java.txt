package com.copo.meuaudioapp;

import java.io.File;

public class GravacaoServico {
    public static String getUltimoArquivo() {
        File pasta = new File("audios_salvos");
        if (!pasta.exists()) pasta.mkdirs();
        File[] arquivos = pasta.listFiles((dir, nome) -> nome.endsWith(".3gp"));
        if (arquivos != null && arquivos.length > 0) {
            return arquivos[arquivos.length - 1].getAbsolutePath();
        }
        return null;
    }
}