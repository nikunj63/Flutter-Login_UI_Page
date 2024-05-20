import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:login_ui_page/botao_animado.dart';
import 'package:login_ui_page/inputCustomizado.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animatcaoBlur;
  Animation<double>? _animacaoFade;
  Animation<double>? _animacaoSize;

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animatcaoBlur = Tween<double>(
      begin: 50,
      end: 0,
       ).animate(
        CurvedAnimation(
          parent: _controller!,
         curve: Curves.ease
        ),
       );

       _animacaoFade = Tween<double>(
        begin: 0,
        end: 1, 
        ).animate(CurvedAnimation(
          parent: _controller!, 
          curve: Curves.easeInOutQuint,
          ),
          );

          _animacaoSize = Tween<double>(
            begin:0,
            end:500,
          ).animate(
            CurvedAnimation(
              parent: _controller!, 
              curve: Curves.decelerate,
              ),
          );

          _controller?.forward();
  }
  @override
  void dispose(){
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //timeDilation = 8;
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _animatcaoBlur!, 
                builder: (context,widget){
                  return Container(
                    height: 400,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/fundo.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _animatcaoBlur!.value,
                        sigmaY: _animatcaoBlur!.value,
                      ) ,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 10,
                            child: FadeTransition(
                              opacity: _animacaoFade! ,
                              child: Image.asset("images/detalhe1.png"),
                              ),
                          ),
                          Positioned(
                            child: FadeTransition(
                              opacity: _animacaoFade! ,
                              child: Image.asset("images/detalhe2.png"),
                            ),
                            ),
                        ],
                      ),
                      ),
                  );
                },
                ),
                Padding(
                  padding:const EdgeInsets.only(left: 40,right: 40,top: 20),
                  child: Column(
                    children: [
                      AnimatedBuilder(
                        animation: _animacaoSize!, 
                        builder: (context,widget){
                          return Container(
                            width: _animacaoSize?.value,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow:const [
                                BoxShadow(
                                  color:Colors.grey,
                                  blurRadius: 80,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Inputcustomizado(
                                  hint: 'email',
                                  obscure: false,
                                  icon: Icon(Icons.person), 
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0.5,
                                        blurRadius: 0.5,
                                      ),
                                    ],
                                  ),
                                ),
                                const Inputcustomizado(
                                  hint: 'Password',
                                  obscure: true,
                                  icon: Icon(Icons.lock),
                                  ),
                              ],
                            ),
                          );

                        },
                        ),
                        const SizedBox(height: 20,),
                        BotaoAnimado(controller:_controller!),
                        const SizedBox(height: 10),
                        FadeTransition(
                          opacity: _animacaoFade!,
                          child: const Text(
                            "Forget Password",
                            style: TextStyle(
                              color: Color.fromRGBO(255,100,127,1),
                              fontWeight: FontWeight.bold,
                            ),
                          ), 
                        )
                    ],
                  ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}