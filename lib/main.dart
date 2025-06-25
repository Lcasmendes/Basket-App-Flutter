import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:basket_app/l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

enum Team { team1, team2 }

class ScoreAction {
  final Team team;
  final int points;

  ScoreAction(this.team, this.points);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('pt')],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      home: const BasketballScoreCounter(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BasketballScoreCounter extends StatefulWidget {
  const BasketballScoreCounter({super.key});

  @override
  State<BasketballScoreCounter> createState() => _BasketballScoreCounterState();
}

class _BasketballScoreCounterState extends State<BasketballScoreCounter> {
  int team1Score = 0;
  int team2Score = 0;
  ScoreAction? lastAction;

  void addPoints(Team team, int points) {
    setState(() {
      lastAction = ScoreAction(team, points);

      if (team == Team.team1) {
        team1Score += points;
      } else {
        team2Score += points;
      }
    });
  }

  void undoLastShot() {
    if (lastAction != null) {
      setState(() {
        if (lastAction!.team == Team.team1) {
          team1Score -= lastAction!.points;
        } else {
          team2Score -= lastAction!.points;
        }
        lastAction = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final Color team1ButtonColor = Colors.blue.shade700;
    final Color team2ButtonColor = Colors.red.shade700;

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.appTitle), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appLocalizations.team1,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$team1Score',
                            style: const TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildScoreButton(
                            appLocalizations.freeThrow,
                            () => addPoints(Team.team1, 1),
                            team1ButtonColor,
                            Colors.white,
                          ),
                          const SizedBox(height: 10),
                          _buildScoreButton(
                            appLocalizations.twoPoints,
                            () => addPoints(Team.team1, 2),
                            team1ButtonColor,
                            Colors.white,
                          ),
                          const SizedBox(height: 10),
                          _buildScoreButton(
                            appLocalizations.threePoints,
                            () => addPoints(Team.team1, 3),
                            team1ButtonColor,
                            Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appLocalizations.team2,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$team2Score',
                            style: const TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildScoreButton(
                            appLocalizations.freeThrow,
                            () => addPoints(Team.team2, 1),
                            team2ButtonColor,
                            Colors.white,
                          ),
                          const SizedBox(height: 10),
                          _buildScoreButton(
                            appLocalizations.twoPoints,
                            () => addPoints(Team.team2, 2),
                            team2ButtonColor,
                            Colors.white,
                          ),
                          const SizedBox(height: 10),
                          _buildScoreButton(
                            appLocalizations.threePoints,
                            () => addPoints(Team.team2, 3),
                            team2ButtonColor,
                            Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: lastAction == null ? null : undoLastShot,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 5,
                ),
                child: Text(appLocalizations.undoLastShot),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreButton(
    String text,
    VoidCallback onPressed,
    Color buttonColor,
    Color textColor,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        elevation: 5,
      ),
      child: Text(text),
    );
  }
}
