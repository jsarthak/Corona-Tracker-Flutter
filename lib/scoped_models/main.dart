import 'package:scoped_model/scoped_model.dart';
import 'connected_models.dart';

class MainModel extends Model
    with
        ConnectedModels,
        AffectedCountryModel,
        GeneralStatsModel,
        HistoricalData {}
